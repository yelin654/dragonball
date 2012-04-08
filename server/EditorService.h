#ifndef EDITORSERVICE_H
#define EDITORSERVICE_H

class EditorService {
public:
    void login(const char* name);
    void loadMetaWork(const char* name);
    //void saveMetaWork(const char* name, const Array<char*>* bytes);
    void loadStory(const char* name, int idx);
};

extern EditorService* editor_service;

#endif
