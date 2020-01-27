# Инструкция по применению:
1. Перенести .my_custom_commands.sh в home директорию:  
  Проще всего будет создать новый .sh файл:
    ```
    cd ~
    touch .my_custom_commands.sh       # или любое другое название по желанию
    ```
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
    subl .bashrc       # или любым другим текстовым редактором
    ```
    Добавить:
    ```
    source ~/.my_custom_commands.sh  
    ```
    Где угодно, например, последней строкой.
