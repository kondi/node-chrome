FROM node:18.1.0

# Xvfb

RUN apt-get update -qqy \
  && apt-get -qqy install xvfb \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Google Chrome

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install google-chrome-stable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && sed -i 's/"$HERE\/chrome"/xvfb-run -a "$HERE\/chrome" --no-sandbox/g' /opt/google/chrome/google-chrome

WORKDIR /workspace
