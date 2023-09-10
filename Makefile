.PHONY: help setup provision

POST_MESSAGE=................................................

help:
	@echo 'Provision arch workstation'
	@echo 
	@echo 'Options:'
	@echo '  setup            prepare the workstation to run the playbook'
	@echo '  provision        provision the workstation'
	@echo ''

setup:
	@echo "Updating the system ${POST_MESSAGE}"
	sudo pacman -Syu
	@echo "Installing Ansible ${POST_MESSAGE}"
	sudo pacman -S ansible

provision:
	@echo "Running playbook ${POST_MESSAGE}"
	ansible-playbook -K provision.yaml -i inventory
