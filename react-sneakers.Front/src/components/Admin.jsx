import { useState } from "react";
import { useSelector } from "react-redux";
import { Link } from "react-router-dom";
import "../main.scss";
import Modal from "./Modal/Modal";
import TableSneaker from "./TableSneaker";

const Admin = () => {
  const userRole = useSelector(({ account }) => account.userRole);

  return userRole === "Admin" ? (
    <div className="inner__page">
      <div className="container">
        <TableSneaker></TableSneaker>
      </div>
    </div>
  ) : (
    <div className="container">
      <div style={{ display: "flex", justifyContent: "center", marginTop: 20 }}>
        У вас нет прав
      </div>
      <Link
        type="button"
        className="green-button cart__empty__button"
        to="/"
        style={{ marginTop: 20, marginBottom: 20 }}
      >
        Go back
        <img alt="arrow" src="/react-sneakers/img/arrow.png" />
      </Link>
    </div>
  );
};

export default Admin;
