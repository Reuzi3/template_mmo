from fastapi import FastAPI
from routers import PRC,wsPeer,WRC
from internal.Dados.banco import dbClients




app = FastAPI(debug=True)


P_request=PRC.PeerRequestConnection(dbClients)
W_request=WRC.WebRequestConnection(dbClients,wsPeer.manager)

app.include_router(P_request.router)
app.include_router(W_request.router)
app.include_router(wsPeer.router)







if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000, workers=2)