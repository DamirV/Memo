#include "leaderboard.h"

LeaderBoard::LeaderBoard(QObject* parent)
    : QAbstractListModel(parent)
    , modelSize(0)
    , ORGANIZATION("MYAPPRU")
    , APPLICATION("Memo")
{
    load();
}

int LeaderBoard::rowCount(const QModelIndex &index) const
{
    Q_UNUSED(index)

    return modelSize;
}

QVariant LeaderBoard::data(const QModelIndex &index, int role) const
{
    if(!index.isValid()){
        return QVariant();
    }

    const int row(index.row());
    return rawData[row];
}

void LeaderBoard::save()
{
    QSettings settings(ORGANIZATION, APPLICATION);
    settings.defaultFormat();

    settings.setValue("leaderModelSize", modelSize);

    settings.beginWriteArray("leaders");

    for(int i = 0; i < modelSize; ++i){
        settings.setArrayIndex(i);
        settings.setValue("leader", rawData[i]);
    }

    settings.endArray();
}

void LeaderBoard::load()
{
    QSettings settings(ORGANIZATION, APPLICATION);
    settings.defaultFormat();

    this->beginResetModel();
    rawData.clear();

    modelSize = settings.value("leaderModelSize").toInt();


    settings.beginReadArray("leaders");

    for(int i = 0; i < modelSize; ++i){
        settings.setArrayIndex(i);
        rawData.push_back(QString(settings.value("leader").toString()));
    }

    settings.endArray();
}

void LeaderBoard::addLeader(QString leader)
{
    beginInsertRows(QModelIndex(), modelSize, modelSize);

    ++modelSize;
    rawData.push_back(leader);
    endInsertRows();

    save();

}

