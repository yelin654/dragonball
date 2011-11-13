#ifndef SECTION_H
#define SECTION_H

class Paragraph;

class Section {
public:
    Section();
    Paragraph* start;

public:
    int new_paragraph();
    delete_paragraph(int idx);
private:
    map<int, Paragraph*> paragraphs;
};

#endif
