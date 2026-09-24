check_in_venv:
	@if test -z $$VIRTUAL_ENV \
		;then printf "Not in a python virtual env, exiting\n" \
		exit 1 \
	;fi

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

checking: check_in_venv
	./scripts/ci/check_all_docker.sh


update_all_dev: check_in_venv
	./scripts/dev/update_all.sh
