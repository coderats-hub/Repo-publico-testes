"""Small deterministic order calculation fixture."""
from decimal import Decimal


def total(prices: list[str]) -> Decimal:
    values = [Decimal(price) for price in prices]
    if any(not value.is_finite() or value < 0 for value in values):
        raise ValueError("Prices must be finite and non-negative")
    return sum(values, Decimal("0"))
