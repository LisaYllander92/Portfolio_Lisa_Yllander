from numbers import Number
from abc import ABC, abstractmethod



class Shapes(ABC):
    """
    Abstract Base Class (ABC) for all geometric shapes in the sub-classes (Rectangle and Circle).

    This class enforces common geometric requirements (area, perimeter, representation) 
    via abstract methods, and provides shared functionality like center position 
    (x, y), translation, and area-based comparison operators.
    """

    def __init__(self, x: Number, y: Number):
        """
        Initializes the center position of the shape (x and y).

        The assignment calls the property setters (self.x = x, self.y = y) to 
        ensure immediate type validation.
        
        Parameters:
        - x (Number): The center position on the x-axis.
        - y (Number): The center position on the y-axis.
        """
        self.x = x
        self.y = y

    """ ---Position Properties (x)--- """
    @property
    def x(self):
        return self._x

    @x.setter
    def x(self, value):
        if not isinstance(value, Number):
            raise TypeError(f"'x' must be a number of an int or float, not {type(value)}")
        self._x = value

    """ ---Position Properties (y)--- """
    @property
    def y(self):
        return self._y 

    @y.setter
    def y(self, value):
        if not isinstance(value, Number):
            raise TypeError(f"'y' must be a number of an int or float, not {type(value)}")
        self._y = value

    """ ---Translation Method--- """
    def translate(self, dx: Number, dy: Number):
        """
        Moves the shape by adding 'dx' along the x-axis and 'dy' along the y-axis.
        Error Handling: Ensures both dx and dy are numbers.
        """
        if not isinstance(dx, Number) or not isinstance(dy, Number):
            raise TypeError("Both 'dx' and 'dy' must be numbers")
        
        # Updates the position using the property setters
        self.x += dx
        self.y += dy

        return self 

    """ ---Abstract Properties (Must be implemented in subclasses)--- """
    @property
    @abstractmethod
    def perimeter(self) -> Number:
        """ Abstract method for calculating the read-only perimeter. """
        pass

    @property
    @abstractmethod
    def area(self) -> Number:
        """Abstract method for calculating the read-only area."""
        pass
    
    """ ---Abstract Representation Methods--- """
    @abstractmethod
    def __repr__(self) -> str:
        """Abstract method for the unambiguous, official string representation."""
        pass

    @abstractmethod
    def __str__(self) -> str:
        """Abstract method for the more "human-readable" string representation."""
        pass

    """ ---Operator Overloading (Comarison)--- """

    @abstractmethod
    def __eq__(self, other) -> bool:
        """ Abstract method for equality (==). Must be defined in subclasses 
        to ensure equality is based on unique dimensions (e.g., radius, length/width). """
        pass

    def __ne__(self, other) -> bool:
        """ Operator overload for 'not equal to' (!=). Based on the result of __eq__. """
        eq_result = self.__eq__(other)
        if eq_result is NotImplemented:
            return NotImplemented
        return not eq_result 

    def __lt__(self, other) -> bool:
        """ Operator overload for 'less than' (<). Comparison is based on area. """
        if not isinstance(other, Shapes):
            return NotImplemented
        return self.area < other.area

    def __gt__(self, other) -> bool:
        """ Operator overload for 'greater than' (>). Comparison is based on area. """
        return self.area > other.area

    def __le__(self, other) -> bool:
        """ Operator overload for 'less than or equal to' (<=). Comparison is based on area. """
        return self.area <= other.area

    def __ge__(self, other) -> bool:
        """ Operator overload for 'greater than or equal to' (>=). Comparison is based on area. """
        return self.area >= other.area



    

    