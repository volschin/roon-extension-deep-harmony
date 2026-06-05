[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/volschin/roon-extension-deep-harmony/badge)](https://securityscorecards.dev/viewer/?uri=github.com/volschin/roon-extension-deep-harmony)
# docker-roon-extension-deep-harmony

The lifetime for Logitech Harmony devices expired. And my own Harmony has been replaced. so this repo is no longer maintained.

    roon-extension-deep-harmony:
      image: volschin/roon-extension-deep-harmony:latest
      container_name: roon-extension-deep-harmony
      restart: unless-stopped
      network_mode: host
      environment:
        - TZ=${TZ}
      volumes:
        - ${HOME_PATH}/ext-harm/config.json:/config.json
        - extension-deep-harmony_logs:/logs/
