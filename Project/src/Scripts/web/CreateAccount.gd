extends Control

var username:String
var password:String
var email:String
var gender:bool
var race:String
var classe:String

func SendAccount():
	
	var message = {"username": username, "password": password,"email":email,"gender":gender, "race":race,"classe":classe}
	Actions.send_http_msg(message,"http://"+Webserver.url+"/register")
	Actions.changeSceane(Actions.sceanes["Login"])

