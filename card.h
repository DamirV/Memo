#ifndef CARD_H
#define CARD_H
#include <QObject>

enum statusType{
    disabled = -1,
    hidden = 0,
};

class Card
{

public:
    Card(int);
    int getValue() const;
    int getStatus() const;

    void hide();
    void show();
    void disable();

    bool operator==(const Card&);
    bool operator==(const int);

private:
     const int value;
     int status;
};

#endif // CARD_H
