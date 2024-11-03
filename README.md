# Wrapper for SimpleX Chat WeatherBot

[<img src="icon.png" alt="SimpleX logo" width="10%"/>](https://simplex.chat/)

SimpleX is a highly secure and sovereign messenger. 

Currently the packaging process only supports Start9os running on AMD64 architecture.

## Dependencies

Install the system dependencies below to build this project by following the instructions in the provided links. You can also find detailed steps to setup your environment in the service packaging [documentation](https://github.com/Start9Labs/service-pipeline#development-environment).

- [docker](https://docs.docker.com/get-docker)
- [docker-buildx](https://docs.docker.com/buildx/working-with-buildx/)
- [start-sdk](https://github.com/Start9Labs/start-os/blob/sdk/backend/install-sdk.sh)
- [deno](https://deno.land/#installation)
- [make](https://www.gnu.org/software/make/)
- [yq](https://mikefarah.gitbook.io/yq)


## Cloning

Clone the project locally:

```
git clone git@github.com:dempsey-ai/weatherbot-startos.git
cd weatherbot-startos
make
```

## Testing performed

- [X] Smoke testing - weatherBot auto accepts connection requests and responds to messages
- [X] Continuity testing - Server config persists across service restarts
- [X] DR testing - Backups restore successfully 

## Roadmap
- [ ] Support for multi-architecture Docker images once SimpleX CLI supports it
- [ ] Server statistics (`log_stats: on` in `smp-server.ini`)
- [ ] Exposing configuration options for custom SMP Server
- [ ] Use official multi-architecture Docker Hub once SimpleX team fixes that
- [ ] Persistent storage for user Location data
