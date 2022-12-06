import sqlite3
from sqlite3 import Cursor, Connection
from typing import Any


class SqliteDatabase:
    """A wrapper to an sqlite database"""

    def __init__(self, db_path) -> None:
        self._conn: Connection = sqlite3.connect(db_path)
        self._cursor: Cursor = self._conn.cursor()

    def __enter__(self):
        """Use this as a context manager"""
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        """Use this as a context manager"""
        self.close()

    @property
    def connection(self) -> Connection:
        return self._conn

    @property
    def cursor(self) -> Cursor:
        return self._cursor

    def commit(self) -> None:
        self.connection.commit()

    def close(self, commit: bool = True) -> None:
        if commit:
            self.commit()
        self.connection.close()

    def execute(self, sql: str, params=None) -> Cursor:
        self.cursor.execute(sql, params or ())

    def fetchall(self):
        return self.cursor.fetchall()

    def fetchone(self):
        return self.cursor.fetchone()

    def query(self, sql: str, params=None) -> Any:
        self.cursor.execute(sql, params or ())
        return self.fetchall()
