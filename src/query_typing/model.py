from dataclasses import dataclass
from typing import TypeVar
from query_typing.model_base import ModelBase, QueryBase


@dataclass
class EmployeeModel(ModelBase):
    department_id: int | None
    name: str


E = TypeVar("E", bound=EmployeeModel)


class EmployeeQuery(QueryBase[E]):
    pass


@dataclass
class DepartmentModel(ModelBase):
    parent_id: int | None
    name: str


D = TypeVar("D", bound=DepartmentModel)


class DepartmentQuery(QueryBase[D]):
    pass
