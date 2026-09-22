CHECK_IN_VENV = if test -z $$VIRTUAL_ENV ;then printf 'Not in a python virtual env, exiting'; exit 1 ;fi

start_dev:
	./scripts/docker/dev.sh

download_models:
	docker compose --env-file .generated/compose/dev.env -f docker-compose.dev.yml exec age-decision-core python scripts/models/download_models.py

stop_dev:
	docker compose --env-file .generated/compose/dev.env -f docker-compose.dev.yml down

regenerate_dev:
	./scripts/config/generate_env.sh dev

create_venv:
	sh -x ./scripts/dev/create_venv.sh

del_venv:
	rm -rf ./.venv/

checking:
	$(CHECK_IN_VENV)
	./scripts/ci/check_all_docker.sh


update_all_dev:
	$(CHECK_IN_VENV)
	./scripts/dev/update_all.sh

