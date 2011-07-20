#!/bin/sh

# Этот скрипт собирает все библиотечные зависимости для файлов в текущей
# директории и поддиректориях. Вывод можно прогрепать на "usr" и " /lib",
# чтобы выявить сборку с неверным префиксом.

#find | xargs -l1 -iZ sh -c "A=\`/usr/bin/ldd \"Z\" 2>/dev/null\`; if [ $? = 0 ]; then echo \"=== Z ===\"; echo \$A | sed 's/)/\n/g'; fi"
find | xargs -l1 -iZ sh -c "A=\`/opt/moment/bin/ldd \"Z\" 2>/dev/null\`; if [ $? = 0 ]; then echo \"=== Z ===\"; echo \$A | sed 's/)/\n/g'; fi"

#cat ~/out | grep -v "/opt/moment" | grep -v linux-gate | grep -v ld-linux | grep -v "not a dy" > ~/out_

