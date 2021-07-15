FROM mono:5.16

# wget -qO- http://opensimulator.org/wiki/Download | grep -Eoi '([^"]+?[0-9].tar.gz)' | head -1 
RUN curl http://opensimulator.org/dist/opensim-0.9.1.1.tar.gz -s | tar xzf -

RUN mv opensim-* opensim
ADD Regions.ini /opensim/bin/Regions/
ADD OpenSim.ini /opensim/bin/
ADD Standalone.ini /opensim/bin/config-include/Standalone.ini
ADD StandaloneCommon.ini /opensim/bin/config-include/StandaloneCommon.ini
COPY isus.oar /opensim/bin/
EXPOSE 9000
WORKDIR /opensim/bin

CMD [ "mono",  "./OpenSim.exe" ]
