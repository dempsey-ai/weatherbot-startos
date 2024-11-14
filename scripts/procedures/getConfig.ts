import { compat, types as T } from "../deps.ts";

export const getConfig: T.ExpectedExports.getConfig = compat.getConfig({
          "debug-mode": {
            "name": "Debug Mode",
            "description": "Enable additional console logging",
            "nullable": false,
            "type": "boolean",
            "default": false
          },
          "simplex-chat-port": {
            "name": "Simplex Chat Port",
            "description": "Port number for Simplex Chat connection",
            "type": "number",
            "nullable": false,
            "default": 5225,
            "range": "[1024,65535]"
          },
          "summer-temp-hot": {
            "name": "Summer Hot Threshold",
            "description": "Temperature threshold for hot weather during summer months",
            "type": "number",
            "nullable": false,
            "default": 85,
            "units": "degrees",
            "range": "[0,110]"
          },
          "temp-hot": {
            "name": "General Hot Threshold",
            "description": "Temperature threshold for hot weather during non-summer months",
            "type": "number",
            "nullable": false,
            "default": 75,
            "units": "degrees",
            "range": "[0,110]"
          },
          "temp-cold": {
            "name": "Cold Threshold",
            "description": "Temperature threshold for cold weather year-round",
            "type": "number",
            "nullable": false,
            "default": 50,
            "units": "degrees",
            "range": "[0,110]"
          },
          "share-bot-address": {
            "name": "Share Bot Address",
            "description": "Allow users to share the weatherBot profile address with others",
            "type": "boolean",
            "nullable": false,
            "default": true
          },
          "bot-display-name": {
            "name": "SimpleX weatherBot Profile Name",
            "description": "Display name for the weatherBot profile that connected users will see",
            "type": "string",
            "nullable": false,
            "default": "WeatherBit.io"
          },
          "weather-provider-api-key": {
            "name": "WeatherBit.io Provider API Key (https://www.weatherbit.io/account/create)",
            "description": "Weather provider specific API key string.  Some providers require an API key, even if free tier is used.  WeatherBit.io provides a free account as well as trial access to higher tier which provides extended forecast periods. There is a data access limit on the free tier, but weatherBot helps by caching the forecast data for each unique location for 60 minutes.",
            "type": "string",
            "nullable": false,
            "default": ""
          },
          "init-host-user": {
            "name": "Initial Host User",
            "description": "Simplex user address for initial host/admin user",
            "type": "string",
            "nullable": true,
            "default": ""
          }
        });
      

  