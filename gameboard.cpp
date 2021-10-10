#include "gameboard.h"

GameBoard::GameBoard(QObject* parent)
    : QAbstractListModel(parent)
    , boardDimension(0)
    , modelSize(0)
    , condition(cardsNotPressed)
    , score(0)
    , progress(0)
    , timer(nullptr)
{
    timer = new QTimer(this);

    generateModel(4);
    connect(timer, &QTimer::timeout, this, &GameBoard::onTimerStoped);
}

int GameBoard::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
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

    std::vector<int> values = generateValues();
    fillData(values);

    this->endResetModel();

    emit dimensionChanged();
    emit scoreChanged();
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

    if(progress == modelSize / 2){
        emit endGame();
    }

    emit dataChanged(createIndex(0, 0), createIndex(modelSize, 0));
}
