FROM node:11

RUN cd /core-backend && yarn install && yarn build && \
    mkdir /opt/work_gate && \
    cp -r /core-backend/bin /opt/work_gate/ungate && \
    cd /opt/work_gate/ungate && \
    yarn install

CMD cd /opt/work_gate/ungate && ls -la && cat package.json && yarn server
