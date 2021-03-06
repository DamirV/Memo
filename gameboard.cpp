#include "gameboard.h"

GameBoard::GameBoard(QObject* parent)
    : QAbstractListModel(parent)
    , boardDimension(0)
    , modelSize(0)
    , condition(cardsNotPressed)
    , score(0)
    , progress(0)
    , canSave(true)
    , timer(nullptr)
{
    timer = new QTimer(this);
    //generateModel(4);
    connect(timer, &QTimer::timeout, this, &GameBoard::onTimerStoped);
}

int GameBoard::rowCount(const QModelIndex &index) const
{
    Q_UNUSED(index)

    return modelSize;
}

QVariant GameBoard::data(const QModelIndex &index, int role) const
{
    if(!index.isValid() || role !=Qt::StatusTipRole){
        return QVariant();
    }

    const int row(index.row());
    return QVariant::fromValue(rawData[row].getStatus());
}

int GameBoard::getScore() const
{
    return score;
}

int GameBoard::getDimension() const
{
    return boardDimension;
}

void GameBoard::generateModel(int _boardDimension)
{
    this->beginResetModel();

    boardDimension = _boardDimension;
    modelSize = boardDimension * boardDimension;
    condition = cardsNotPressed;
    score = 0;
    progress = 0;
    canSave = true;

    std::vector<int> values = generateValues();
    fillData(values);

    this->endResetModel();

    emit dimensionChanged();
    emit scoreChanged();
}

void GameBoard::saveGame()
{
    if(timer->isActive()){
        onTimerStoped();
    }

    QSettings settings(ORGANIZATION, APPLICATION);
    settings.defaultFormat();

    if(!canSave){
        settings.setValue("saved", false);
        return;
    }
    settings.setValue("saved", true);

    settings.setValue("boardDimension", boardDimension);
    settings.setValue("condition", condition);
    settings.setValue("score", score);
    settings.setValue("progress", progress);

    settings.setValue("firstCardIndex", firstCardIndex);
    settings.setValue("secondCardIndex", secondCardIndex);

    settings.beginWriteArray("cards");

    for(int i = 0; i < modelSize; ++i){
        settings.setArrayIndex(i);
        settings.setValue("cardValue", rawData[i].getValue());
        settings.setValue("cardStatus", rawData[i].getStatus());
    }

    settings.endArray();
    emit saveCreated();
}

void GameBoard::loadGame()
{
    QSettings settings(ORGANIZATION, APPLICATION);
    settings.defaultFormat();

    this->beginResetModel();

    rawData.clear();

    boardDimension = settings.value("boardDimension").toInt();
    modelSize = boardDimension * boardDimension;

    condition = settings.value("condition").toInt();
    score = settings.value("score").toInt();
    progress = settings.value("progress").toInt();

    firstCardIndex = settings.value("firstCardIndex").toInt();
    secondCardIndex = settings.value("secondCardIndex").toInt();

    settings.beginReadArray("cards");

    for(int i = 0; i < modelSize; ++i){
        settings.setArrayIndex(i);

        rawData.push_back(Card(settings.value("cardValue").toInt()));

        switch (settings.value("cardStatus").toInt()) {
        case -1:
                rawData[i].disable();
            break;

        case 0:
            rawData[i].hide();
            break;

        default:
            rawData[i].show();
        }
    }

    settings.endArray();

    this->endResetModel();

    emit dimensionChanged();
    emit scoreChanged();
}

bool GameBoard::checkSave()
{
    QSettings settings(ORGANIZATION, APPLICATION);
    settings.defaultFormat();

    return settings.value("saved").toBool();
}

void GameBoard::onCardClicked(int index)
{
    if(rawData[index].getStatus() == disabled){
        return;
    }

    switch (condition) {
    case cardsNotPressed:
        firstCardIndex = index;
        rawData[firstCardIndex].show();

        condition = oneCardPressed;

        ++score;

        emit scoreChanged();
        break;

    case oneCardPressed:
        secondCardIndex = index;

        if(firstCardIndex == secondCardIndex){
            return;
        }

        rawData[secondCardIndex].show();

        timer->start(500);

        condition = twoCardsPressed;
        break;

    case twoCardsPressed:
        onTimerStoped();
        onCardClicked(index);
        break;
    }

    emit dataChanged(createIndex(0, 0), createIndex(modelSize, 0));
}

std::vector<int> GameBoard::generateValues()
{
    std::vector<int> values;
    values.resize(modelSize);
    int k = 0;

    for(int i = 0; i < modelSize / 2; ++i){
        values[k++] = i + 1;
        values[k++] = i + 1;
    }

    for (int i = 0; i < modelSize; ++i) {
        int r = i + rand() % (values.size() - i);
        std::swap(values[i], values[r]);
    }

    return values;
}

void GameBoard::fillData(const std::vector<int> &values)
{
    rawData.clear();
    for(int i = 0; i < modelSize; ++i){
        rawData.push_back(Card(values[i]));
    }
}

void GameBoard::onTimerStoped()
{
    timer->stop();
    checkCards();
    condition = cardsNotPressed;
}

void GameBoard::checkCards()
{
    if(rawData[firstCardIndex] == rawData[secondCardIndex]){
        rawData[firstCardIndex].disable();
        rawData[secondCardIndex].disable();
        ++progress;
    }
    else{
        rawData[firstCardIndex].hide();
        rawData[secondCardIndex].hide();
    }

    isEndGame();

    emit dataChanged(createIndex(0, 0), createIndex(modelSize, 0));
}

void GameBoard::isEndGame()
{
    if(progress == modelSize / 2){
        canSave = false;
        emit endGame();
    }
}
