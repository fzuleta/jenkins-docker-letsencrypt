# Private Jenkins with Let's Encrypt SSL

Make sure you have a domain(or subdomain) and SSH access to an instance. This works well under a DigitalOcean's Ubuntu with Docker and Docker Compose installed.

## Steps
0. Run as `root`
0. `chmod -R 777 jenkins/jenkins_home`
1. `sudo chmod -R 777 /var/run/docker.sock` it isnt ideal, but only thing that works
2. Set in `docker-compose.yml` and `ssl_gen.sh` the **DOMAIN=domain.com** .
3. Delete all **DELETE_ME.yml** files in `certs`, `certs-data`, `jenkins/jenkins_home`, `jenkins/projects` (keep folders).
    - ```
    rm certs/DELETE_ME.yml && rm certs-data/DELETE_ME.yml && rm jenkins/jenkins_home/DELETE_ME.yml && rm jenkins/projects/DELETE_ME.yml
    ```
4. `docker-compose up -d`
5. `chmod +x *.sh && ./ssl_gen.sh`  
6. After it succeeds, start it with `docker-compose restart`

# Automatic cron setup ssl renewal

This will schedule a renewal of the SSL cert with Let's Encrypt every 15 days.
1. `crontab -u $USER -e`
2. `0 0 */15 * *  /home/gg/jenkins/ssl_renew.sh`

# Notes and Gotchas
- this works better as `root` user, but feel free to try with other users.
- Is there a DNS **A** record pointing to the server?
- Are you using domain.com? (use your own)
- If let's encrypt fails, delete all certs and certs-data files and try again.
- Did you make sure all the `DELETE_ME.yml` are gone?
- Tweak jenkins memory by going into jenkins.dockerfile `ENV JAVA_OPTS="-Xmx2048m"`

## Need to install Docker in your VPS machine?
https://docs.docker.com/install/linux/docker-ce/ubuntu/

https://docs.docker.com/compose/install/

### Be sure to donate to **letsencrypt.org**!
