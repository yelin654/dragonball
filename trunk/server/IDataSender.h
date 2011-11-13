#ifndef IDATASENDER_H
#define IDATASENDER_H

class OutputStream;
class IRemote;

class IDataSender {
public:
    virtual OutputStream* get_output_stream(IRemote* remote, int size)=0;
};

#endif
