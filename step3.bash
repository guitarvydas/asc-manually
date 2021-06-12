#!/bin/bash
sed -E -e '/^# rect/d' <hw_e.md >hw_1.md
sed -E -e '/^# rect/d' <hwsub_e.md >hwsub_1.md
sed -E -e '/^# rect/d' <hwhello_e.md >hwhello_1.md
