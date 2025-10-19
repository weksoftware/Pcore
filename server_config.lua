local server_config = {}

server_config.enet_type = nil -- host для сервера
server_config.port = 60776 -- стандартный 60776
server_config.ip = "localhost"
server_config.spawn_x = 0 -- Координаты появления игроков
server_config.spawn_y = 0
server_config.update_area = 40 -- Расстояние влево и вправо от игроков для обновления карты
server_config.update_area_time = 0.5 -- Время обновления карты вокруг игроков в секундах
server_config.update_blocks_time = 0.5 -- Время отправки обновлений отдельных изменённых блоков
server_config.hello_message = "Buongiorno!" -- Приветственное сообщение

return server_config