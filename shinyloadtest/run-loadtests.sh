#! /bin/bash

shinycannon recording.log https://rst-precise-grubworm.soleng.rstudioservices.com/rsconnect/sync --workers 20 --loaded-duration-minutes 20 --output-dir runs/sync               
shinycannon recording.log https://rst-precise-grubworm.soleng.rstudioservices.com/rsconnect/sync-scaled --workers 20 --loaded-duration-minutes 20 --output-dir runs/sync-scaled
shinycannon recording.log https://rst-precise-grubworm.soleng.rstudioservices.com/rsconnect/async --workers 20 --loaded-duration-minutes 20 --output-dir runs/async
shinycannon recording.log https://rst-precise-grubworm.soleng.rstudioservices.com/rsconnect/async2 --workers 20 --loaded-duration-minutes 20 --output-dir runs/async2
