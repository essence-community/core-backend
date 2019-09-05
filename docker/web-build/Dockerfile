FROM node:11

CMD git clone git@github.com:essence-community/core-frontend.git --branch 2.0.0 --single-branch --depth 1 && \
    cd /core-frontend/source/app/@essence/essence-constructor-share && \
    yarn install && \
    yarn build && \
    cd /core-frontend/source/app && \
    yarn install && \
    yarn build && \
    rm -rf /dist/front && \
    cp -r build /dist/front

