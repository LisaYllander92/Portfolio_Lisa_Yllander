from shapes import Shapes
from numbers import Number # To make sure the value is a number
import math
import matplotlib.pyplot as plt

class Rectangle(Shapes):
    """
    Represents a geometric rectangle, inheriting center position (x, y) and 
    translation capabilities from the abstract Shapes class.

    It implements mandatory abstract methods (area, perimeter, __eq__, __repr__, __str__) 
    and adds unique functionality like is_square and draw().
    """

    def __init__(self, length: Number, width: Number, x: Number = 0, y: Number = 0):
        """
        Initializes the Rectangle with mandatory dimensions and optional center position.

        Parameters:
        - length (Number): The length of the rectangle.
        - width (Number): The width of the rectangle.
        - x (Number): Center position on the x-axis. Defaults to 0.
        - y (Number): Center position on the y-axis. Defaults to 0.
        """
        # Setters are called here, running validation (type/negative checks)
        self.length = length
        self.width = width

        # Initializes inherited properties (x, y) via Shapes.__init__
        super().__init__(x, y)

    """ ---Length properties--- """
    @property
    def length(self):
        return self._length
    
    @length.setter
    def length(self, value):
        if not isinstance(value, Number):
            raise TypeError(f"Length must be a non-negative number, not {type(value).__name__}")
        if value < 0:
            raise ValueError("Length cannot be negative.")
        self._length = value

    """ ---Width properties--- """

    @property
    def width(self):
        return self._width
    
    @width.setter
    def width(self, value):
        if not isinstance(value, Number):
            raise TypeError(f"Width must be a non-negative number, not {type(value).__name__}")
        if value < 0:
            raise ValueError("Width cannot be nagative.")
        self._width = value

    """ ---Abstract Properties Implementation--- """

    @property
    def perimeter(self) -> Number:
        """ Read-only property calculating the perimeter """
        return 2 * (self.length + self.width)

    @property
    def area(self) -> Number:
        """ Read-only property calculating the area """
        return self.length * self.width
    
    """ ---Operator Overload (Equality)--- """

    def __eq__(self, other) -> bool:
        """ Operator overload for equality (==). Rectangles are equal if they have
        the same dimensions, regardless of order, otherwise they are NOT equal"""
        print(f"Comparing {self.length}x{self.width} with {other.length}x{other.width}")
        #if type(other) is not type(self):
        if not isinstance(other, Rectangle):
            return NotImplemented

        # Sorts dimensions to ensure a 5x4 rectangle equals a 4x5 rectangle.
        self_sides = sorted([self.length, self.width])
        other_sides = sorted([other.length, other.width])
        
        return self_sides == other_sides

    """ ---Unique Method--- """
    def is_square(self) -> bool:
        """Checks if the rectangle is a square (length equals width)."""
        # Uses math.isclose() for reliable comparison, especially with floats
        return math.isclose(self.length, self.width)
        #return self.length == self.width

    """ ---Representation--- """
    def __repr__(self) -> str:
        """ Returns a unambiguous string representation (for debugging). """
        return f"Rectangle ({self.x}, {self.y} with length: {self.length} and width: {self.width})"

    def __str__(self) -> str:
        """ Returns a more "human-readable" string representation. """
        return f"Rectangle with length: {self.length} and width: {self.width}, has the area of: {self.area}"

    """ ---Visualization--- """    
    def draw(self):
        """ Visualizes the rectangle using Matplotlib. Plot limits are manually set 
            to ensure the entire shape is visible and centered. """

        # #1. Setup: Creates a Figure (window) and Axes (plot area).
        fig, ax = plt.subplots(1) 

        # 2. Determine Start Position: Matplotlib requires the bottom-left corner.
        # Calculation: (Center X - half Length, Center Y - half Width)
        x_start = self.x - self.length /2
        y_start = self.y - self.width /2

        # 3. Set Plot Limits
        # Calculates symmetric boundaries around the center based on dimensions + margin.
        margin_x = self.length * 0.2
        margin_y = self.width * 0.2

        # Sets x-axis limits: (Left edge - Margin) to (Right edge + Margin)
        ax.set_xlim(self.x - self.length / 2 - margin_x, self.x + self.length / 2 + margin_x)
        # Sets y-axis limits: (Bottom edge - Margin) to (Top edge + Margin)
        ax.set_ylim(self.y - self.width / 2 - margin_y, self.y + self.width / 2 + margin_y)

        # 4. Create and Add Patch: Uses plt.Rectangle to define the geometry.
        rect_patch = plt.Rectangle(
            (x_start, y_start), # Bottom left corner coordinates
            self.length,        # Width of the patch
            self.width,         # Length of the patch
            color = 'green',
            alpha = 0.5
        )
        ax.add_artist(rect_patch) # adds the rectangle shape to the plot.

        # 5. Center Marker: Marks the center (self.x, self.y) with a red dot.
        ax.plot(self.x, self.y, 'ro') 

        # 6. Aspect Ratio: Ensures the shape is not deformed (x-unit = y-unit)
        ax.set_aspect('equal', adjustable = 'box')

        # 7. Final Display
        plt.title(f"Rectangle: {self.length} x {self.width}, center = ({self.x}, {self.y})")
        plt.xlabel("x-axis")
        plt.ylabel("y-axis")
        plt.grid(True)
        plt.show()
