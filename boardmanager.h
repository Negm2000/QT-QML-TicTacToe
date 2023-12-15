#ifndef BOARDMANAGER_H
#define BOARDMANAGER_H

#include <QObject>
#include <QQmlEngine>

class BoardManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit BoardManager(QObject *parent = nullptr);

signals:
};

#endif // BOARDMANAGER_H
