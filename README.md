[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/{owner}/{repo}/badge)](https://securityscorecards.dev/viewer/?uri=github.com/{owner}/{repo})
# docker-roon-extension-deep-harmony



    roon-extension-deep-harmony:
      image: volschin/roon-extension-deep-harmony:latest
      container_name: roon-extension-deep-harmony
      restart: unless-stopped
      network_mode: host
      environment:
        - TZ=${TZ}
      volumes:
        - ${HOME_PATH}/ext-harm/config.json:/app/config.json
        - extension-deep-harmony_logs:/app/logs/

