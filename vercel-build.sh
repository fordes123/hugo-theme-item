#!/bin/bash

# default versions
NODE_VERSION='20.17.0';
GO_VERSION='1.22.0';
HUGO_VERSION='0.130.0';

# install Node.js
# echo "Installing Node.js $NODE_VERSION..."
# curl -sSOL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.gz
# tar -xzf node-v${NODE_VERSION}.tar.gz
# export PATH=$PATH:/usr/local/bin
# rm -rf node-v${NODE_VERSION}.tar.gz

echo "USING NODE VERSION: $(node -v)"

# install Go
echo "Installing Go $GO_VERSION..."
curl -sSOL https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz
tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
rm -rf go${GO_VERSION}.linux-amd64.tar.gz
go version

# install Hugo
echo "Installing Hugo $HUGO_VERSION..."
curl -sSOL https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz
tar -xzf hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz
mv hugo /usr/local/bin/
rm -rf hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz
hugo version

# change to the project directory
echo "Change project directory..."
mkdir -p hugo-theme-item
mv ./* hugo-theme-item/
cd hugo-theme-item

# install dependencies
echo "Installing project dependencies..."
#npm install -g yarn
yarn

# run the build command
echo "Running the build command..."
yarn build

# update the baseurl
echo "Update the baseurl..."
if [ -n "$VERCEL_URL" ]; then
    sed -i "s#baseurl:.*#baseurl: \"https://$VERCEL_URL/\"#" exampleSite/hugo.yaml
fi