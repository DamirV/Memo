#include "card.h"

Card::Card(int _value)
    : value(_value)
    , status(hidden)
{

}

int Card::getStatus() const{
    return status;
}

void Card::hide()
{
    status = hidden;
}

void Card::show()
{
    status = value;
}

void Card::disable()
{
    status = disabled;
}

bool Card::operator==(const Card& card){
    return value == card.value;
}

bool Card::operator==(const int _value){
    return value == _value;
}

