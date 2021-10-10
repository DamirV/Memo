#ifndef GAMEBOARD_H
#define GAMEBOARD_H
#include <QAbstractListModel>
#include <QTimer>
#include "card.h"

enum conditions{
    cardsNotPressed = 0,
    oneCardPressed = 1,
    twoCardsPressed = 2
};

class GameBoard: public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int dimension READ getDimension NOTIFY dimensionChanged)
    Q_PROPERTY(int score READ getScore NOTIFY scoreChanged)

public:
    GameBoard(QObject* parent = nullptr);
    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role = Qt::StatusTipRole)const override;
    int getScore() const;
    int getDimension() const;

public slots:
    Q_INVOKABLE void onCardClicked(int index);
    Q_INVOKABLE void generateModel(int _boardDimension);

signals:
    void scoreChanged();
    void dimensionChanged();
    void endGame();

private:
    QVector<Card> rawData;
    int boardDimension;
    int modelSize;

    int firstCardIndex;
    int secondCardIndex;
    int condition;
    int score;
    int progress;
    QTimer *timer;

    std::vector<int> generateValues();
    void fillData(const std::vector<int>&);
    void onTimerStoped();
    void checkCards();

};

#endif // GAMEBOARD_H
