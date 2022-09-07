from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse, HTMLResponse, Response
import requests

app = FastAPI()

@app.get("/ping")
def root():
    return "pong"

@app.get('/{game_id}', response_class=HTMLResponse)
def index(game_id: str):
    tank_ids = game_ids.split("-")
    game_id = "".join(tank_ids)

    return f"""
        <html>

        <head>
            <meta charset="UTF-8" />
            <style>
                body {{
                    background: linear-gradient(135deg,
                            white 0%,
                            white 49%,
                            black 49%,
                            black 51%,
                            white 51%,
                            white 100%);
                    background-repeat: repeat;
                    background-size: 20px 20px;
                    display: flex;
                    flex-direction: column-reverse;
                    align-items: center;                    
                }}

                canvas {{
                    background-color: white;
                }}
            </style>
        </head>

        <body>
            <div id="log">
                <select id="sel">
                    {
                        "".join([
                            f"<option value='{game_id}{t}-{i}'>{t}</option>"
                            for i, t in enumerate(tank_ids)
                        ])
                    }
                </select>
            </div>
        </body>

        <script type="module">
            import init from './{game_id}/ctviewer.js'
            init()

            var select = document.querySelector('#sel');
            select.addEventListener('change',function(){{
                alert('changed');
            }});
        </script>

        </html>
    """

@app.get('/{game_id}/ctviewer.js')
def f1(game_id: str):
    return FileResponse('/ctweb/web/ctviewer.js')

@app.get('/{game_id}/ctviewer_bg.wasm')
def f2(game_id: str):
  return FileResponse('/ctweb/web/ctviewer_bg.wasm')

@app.get('/{game_id}/ctviewer_bg.wasm.d.ts')
def f3(game_id: str):
  return FileResponse('/ctweb/web/ctviewer_bg.wasm.d.ts')

@app.get('/assets/sim/{game_id}')
def f4(game_id: str):
    game_id = "/".join(game_id.split(".")[0].split("-"))

    print(game_id)
    r = requests.get(f'http://172.17.0.1:8089/sim/{game_id}')

    return Response(content=r.text, media_type="text/plain")

app.mount("/assets", StaticFiles(directory="/ctweb/assets"), name="assets")