from fastapi import APIRouter, WebSocket
from internal.Managers.P_Manager import P_manager

router = APIRouter()

manager = P_manager()


@router.websocket("/ws/{client_token}")
async def websocket_endpoint(websocket: WebSocket, client_token: str) -> None:
    await manager.connect(websocket, client_token)