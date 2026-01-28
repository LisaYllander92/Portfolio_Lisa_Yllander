from shapes import Shapes
import math # to calculate pi and use isclose
from numbers import Number  # to make sure the value is a number
import matplotlib.pyplot as plt # to plot the shapes

class Circle(Shapes):
    """
    Represents a geometric circle, inheriting center position (x, y) and 
    translation capabilities from the abstract Shapes class.

    It implements mandatory abstract methods (area, perimeter, __eq__, __repr__, __str__) 
    and adds unique functionality like is_unit_circle() and draw().
    """

    def __init__(self, x: Number = 0, y: Number = 0, radius: Number = None):
        """
        Initializes the Circle. x and y are optional (default 0). 
        Radius is mandatory and checked via the setter.
        
        Parameters:
        - x (Number): The center position on the x-axis. Defaults to 0.
        - y (Number): The center position on the y-axis. Defaults to 0.
        - radius (Number): The radius of the circle. (Mandatory if not None).
        """
        # Triggers the radius setter for immediate validation (including None check)
        self.radius = radius
        # Initializes inherited properties (x, y) via Shapes.__init__
        super().__init__(x, y)

    """ ---Radius Properties (Error Handling)--- """
    @property
    def radius(self):
        return self._radius
    
    @ radius.setter
    def radius(self, value):
        if value is None:
            # Using ValueError for logical errors (missing mandatory value)
            raise ValueError("You must put in a value for radius")
        if not isinstance(value, Number):
            raise TypeError(f"Radius must be a non-negative number, not {type(value).__name__}")
        if value < 0:
            raise ValueError("Radius can't be negative")
        self._radius = value

    """ ---Abstract Properties Implementation--- """
    @property
    def perimeter(self) -> Number:
        """ Read-only property calculating the circumference. """
        return 2 * math.pi * self.radius

    @property
    def area(self) -> Number:
        """ Read-only property calculating the area. 
            The result is rounded to 2 decimal places. """
        c_area = math.pi * self.radius**2
        return round(c_area, 2) 
    
    """ ---Operator Overload (Equality)--- """
    def __eq__(self, other) -> bool:
        """ Operator overload for equality (==). Circles are equal if their radii are the same.
            Uses math.isclose() for robust floating-point comparison. """
        if not isinstance(other, Circle):
            return NotImplemented  
        return math.isclose(self.radius, other.radius)
        
    """ ---Unique Method--- """
    def is_unit_circle(self) -> bool:
        """ Checks if the circle is a unit circle (radius = 1.0 and center at (0.0, 0.0)).
            Uses math.isclose() for all comparisons."""
        radius_ok = math.isclose(self.radius, 1.0)
        x_ok = math.isclose(self.x, 0.0)
        y_ok = math.isclose(self.y, 0.0)

        return radius_ok and x_ok and y_ok
         
    """ ---Representations--- """     
    def __repr__(self) -> str:
        """ Returns a unambiguous string representation (for debugging). """
        return f"Circle(x={self.x}, y={self.y}, radius={self.radius})"
    
    def __str__(self) -> str:
        """ Returns a more "human-readable" string representation. """
        return f"The circle at ({self.x}, {self.y}) with radius: {self.radius} \nhas the area of:{self.area:.2f}"
    
    """ ---Visualization--- """
    def draw(self):
        """ Visualizes the circle using Matplotlib. Plot limits are manually set 
            to ensure the entire shape is visible and centered. """

        # 1. Setup: Creates a Figure (window) and Axes (plot area).
        fig, ax = plt.subplots(1)

        # 2. Set Plot Limits 
        # Calculates symmetric boundaries (low and high) around the center (x, y) 
        # based on the radius, plus a margin to ensure the circle is fully visible.
        margin = self.radius * 1.5 # Margin calculation (50% of radius)

        # Sets limits for x-axis and y-axis
        ax.set_xlim(self.x - margin, self.x + margin)
        ax.set_ylim(self.y - margin, self.y + margin)

        # 3. Create and Add Patch
        # plt.Circle creates the object (patch) used for the drawing
        circle_patch = plt.Circle(
            (self.x, self.y), # Center position 
            self.radius,      # Radius dimention
            color = 'pink',   
            alpha = 0.5       
        )
        ax.add_artist(circle_patch) # Adds the circle shape to the plot.

        # 4. Center Marker: Adds a visible point at the center coordinates.
        ax.plot(self.x, self.y, 'ro') 

        # 5. Aspect Ratio: Ensures the circle is not deformed (x-unit = y-unit)
        ax.set_aspect('equal', adjustable = 'box')

        # 6. Final Display
        plt.title(f"Circle: radius = {self.radius}, center = ({self.x}, {self.y})")
        plt.xlabel("X-axis")
        plt.ylabel("Y-axis")
        plt.grid(True)
        plt.show()
