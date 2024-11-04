import { compat, types as T } from "../deps.ts";

export const getConfig: T.ExpectedExports.getConfig = compat.getConfig({
          "debug-mode": {
            "name": "Debug Mode",
            "description": "Enable additional console logging",
            "type": "boolean",
            "default": false
          },
          "APP_DATA": {
            "name": "Environment Specific App Data Directory",
            "description": "Directory for environment specific application data",
            "type": "string",
            "nullable": false,
            "default": ""
          },
          "simplex-chat-port": {
            "name": "Simplex Chat Port",
            "description": "Port number for Simplex Chat connection",
            "type": "number",
            "default": 5222,
            "range": "[1024,65535]"
          },
          "summer-temp-hot": {
            "name": "Summer Hot Threshold",
            "description": "Temperature threshold for hot weather during summer months",
            "type": "number",
            "default": 85,
            "units": "degrees",
            "range": "[0,110]"
          },
          "temp-hot": {
            "name": "General Hot Threshold",
            "description": "Temperature threshold for hot weather during non-summer months",
            "type": "number",
            "default": 75,
            "units": "degrees",
            "range": "[0,110]"
          },
          "temp-cold": {
            "name": "Cold Threshold",
            "description": "Temperature threshold for cold weather year-round",
            "type": "number",
            "default": 50,
            "units": "degrees",
            "range": "[0,110]"
          },
          "share-bot-address": {
            "name": "Share Bot Address",
            "description": "Allow users to share the weatherBot profile address with others",
            "type": "boolean",
            "default": true
          },
          "init-host-user": {
            "name": "Initial Host User",
            "description": "Simplex user address for initial host/admin user",
            "type": "string",
            "nullable": true,
            "default": ""
          }
        });
      

  