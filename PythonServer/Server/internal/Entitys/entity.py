from internal.Managers.Math_Manager import Vector2



class Stat:
    def __init__(self,race, classe ,hp,sp,att,mag,skl,spd,lck,df,res,Countdown):
        self.Lvl = 0
        self.exp = 0
        self.race = race
        self.classe = classe
        self.hp = hp
        self.sp = sp
        self.att = att
        self.mag = mag
        self.skl = skl
        self.spd = spd
        self.lck = lck
        self.df = df
        self.res = res
        self.Countdown = Countdown
    def __mul__(self, scalar):
        return Stat(self.race ,self.classe, self.hp * scalar, self.sp * scalar, self.att*scalar, self.mag * scalar, self.skl *scalar, self.spd*scalar, self.lck*scalar, self.df*scalar,self.res*scalar,self.Countdown*scalar)



class Entity:
    def __init__(self,stat):
        self.baseStats = Stat(*stat)
        self.stat = self.baseStats * 1
        self.position = Vector2(0,0)
        self.rotation = Vector2(0,0)