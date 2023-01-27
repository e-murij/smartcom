from dataclasses import dataclass
from typing import TypeVar, Sequence, Generic


@dataclass
class ModelBase:
    id: int


T = TypeVar("T", bound=ModelBase)


class QueryBase(Generic[T]):
    models: Sequence[T]

    class NotFoundError(Exception):
        pass

    def __init__(self, models: Sequence[T]) -> None:
        self.models = models

    def all(self) -> Sequence[T]:
        return self.models

    def get(self, id: int) -> T:
        for model in self.models:
            if model.id == id:
                return model

        raise self.NotFoundError()
