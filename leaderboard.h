#ifndef LEADERBOARD_H
#define LEADERBOARD_H

#include <QAbstractListModel>
#include <QSettings>

class LeaderBoard: public QAbstractListModel
{
    Q_OBJECT

public:

    LeaderBoard(QObject* parent = nullptr);

    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole)const override;

public slots:
    Q_INVOKABLE void save();
    Q_INVOKABLE void load();
    Q_INVOKABLE void addLeader(QString leader);

private:
    int modelSize;
    QVector<QString> rawData;

    const QString ORGANIZATION;
    const QString APPLICATION;
};

#endif // LEADERBOARD_H
