## Инструкция по применению:
1. Перенести .my_custom_commands.sh в home директорию:  
  Проще всего будет создать новый .sh файл:
    ```
    cd ~
    touch .my_custom_commands.sh  # или любое другое название по желанию
    ```
    И скопировать в него содержимое .my_custom_commands.sh
2. Перенести папку utilities куда угодно, добавить её путь в поле UT_PATH файла .my_custom_commands.sh:
    ```
    UT_PATH=/your/own/path/utilities/
    ```
3. Добавить в терминал команды:  
  Либо временно (придется повторять при перезапуске терминала): 
    ```
    source ~/.my_custom_commands.sh  
    ```
    Либо в файл ~/.bashrc:   
    ```
    cd ~
    subl .bashrc                  # или любым другим текстовым редактором
    ```
    Добавить:
    ```
    source ~/.my_custom_commands.sh  
    ```
    Где угодно, например, последней строкой.
    
## Команды:  
1. crun:  
  Для этой команды можно настроить сборку файла (по дефолту стоит gcc -Wall):   
    ```
    crun config "gcc -Wall"       # в "" можно добавить флаги и что душа пожелает  
    ```
    И нужно ли вообще производить сборку:  
    ```
    crun config -b true           # false в противном случае
    ```
    Посмотреть текущие конфигурации:
    ```
    crun info
    ```
    Применение:
    ```
    crun your_c_file.c            # если сборку производить не надо, то передать исполняемый файл
    ```
2. goto:
    ```
    goto labels                   # текущий список меток
    goto add label_name           # добавить текущий путь под меткой label_name
    goto add label_name /pa/th    # добавить путь /pa/th под меткой label_name
    goto del all                  # удалить все метки
    goto del label_name           # удалить путь под меткой label_name
    goto rename old_lbl new_lbl   # переименовать метку old_lbl в new_lbl
    goto label_name               # перейти по метке
    ```
