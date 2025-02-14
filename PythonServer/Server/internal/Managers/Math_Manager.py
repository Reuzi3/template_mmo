import math

class Vector2:
    def __init__(self, x=0, y=0):
        self.x = x
        self.y = y

    def __add__(self, other):
        return Vector2(self.x + other.x, self.y + other.y)

    def __sub__(self, other):
        return Vector2(self.x - other.x, self.y - other.y)

    def __mul__(self, scalar):
        return Vector2(self.x * scalar, self.y * scalar)

    def __truediv__(self, scalar):
        if scalar == 0:
            raise ZeroDivisionError("Division by zero is not allowed.")
        return Vector2(self.x / scalar, self.y / scalar)

    def length(self):
        return math.sqrt(self.x ** 2 + self.y ** 2)

    def normalize(self):
        length = self.length()
        if length == 0:
            return Vector2(0, 0)
        return self / length

    def dot(self, other):
        return self.x * other.x + self.y * other.y

    def cross(self, other):
        return self.x * other.y - self.y * other.x

    def angle_to(self, other):
        dot_product = self.dot(other)
        magnitudes = self.length() * other.length()
        if magnitudes == 0:
            return 0  # Avoid division by zero
        return math.acos(dot_product / magnitudes)

    def distance_to(self, other):
        return (other - self).length()

    def __str__(self):
        return f"({self.x}, {self.y})"
