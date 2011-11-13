#ifndef PARAGRAPH_H
#define PARAGRAPH_H

class Paragraph {
public:
    Paragraph* pre;
    Paragraph* next;

public:
    virtual void excute();
    char* default_background;
};

#endif
