import { useEffect, useState } from "react";
import Sneaker from "../Api/Sneaker";
import "../main.scss";
import Modal from "./Modal/Modal";

const TableSneaker = () => {
  const [sneakersData, setSneakersData] = useState([]);
  const [modalActive, setModalActive] = useState(false);
  const [modalEditActive, setModalEditActive] = useState(false);
  const [id, setId] = useState(0);
  const [title, setTitle] = useState("");
  const [price, setPrice] = useState("");
  const [img, setImg] = useState("");

  useEffect(() => {
    fetchPosts();
  }, []);

  async function fetchPosts() {
    const res = await Sneaker.getAll();
    setSneakersData(res);
  }

  async function EditSneaker(id) {
    console.log(1);
    const res = await Sneaker.getById(id);
    setId(res.id);
    setTitle(res.title);
    setPrice(res.price);
    setImg(res.img);
    setModalEditActive(true);
  }

  async function DeleteSneaker(id) {
    await Sneaker.DeleteById(id);
    window.location.reload();
  }

  async function Post() {
    const newPost = {
      id: 0,
      title: title,
      price: price,
      img: img,
    };
    const jsonPost = JSON.stringify(newPost);
    let id = await Sneaker.post(jsonPost);
    if (id > 0) {
      setModalActive(false);
      alert("Товар успешно добавлен");
    } else {
      alert("Товар не добавился добавлен");
    }
  }

  async function Put() {
    const newPost = {
      id: id,
      title: title,
      price: price,
      img: img,
    };
    const jsonPost = JSON.stringify(newPost);
    await Sneaker.put(jsonPost);
    setModalEditActive(false);
  }

  function AddSneaker() {
    setId("");
    setTitle("");
    setPrice("");
    setImg("");
    setModalActive(true);
  }

  return (
    <div className="t_c">
      <Modal key="1" active={modalActive} setActive={setModalActive}>
        <form>
          <div className="form__modal">
            <label>Название</label>
            <input
              placeholder="Nike"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
            ></input>
          </div>
          <div className="form__modal">
            <label>Цена</label>
            <input
              placeholder="500"
              value={price}
              onChange={(e) => setPrice(e.target.value)}
            ></input>
          </div>
          <div className="form__modal">
            <label>Img</label>
            <input
              placeholder="ссылка на картинку"
              value={img}
              onChange={(e) => setImg(e.target.value)}
            ></input>
          </div>
          <button
            onClick={() => Post()}
            style={{
              display: "flex",
              margin: "0px auto",
              backgroundColor: "lightgrey",
              padding: "10px 30px",
            }}
          >
            Add
          </button>
        </form>
      </Modal>

      <Modal key="2" active={modalEditActive} setActive={setModalEditActive}>
        <form>
          <div className="form__modal">
            <label>Id</label>
            <input
              disabled
              value={id}
              onChange={(e) => setId(e.target.value)}
            ></input>
          </div>
          <div className="form__modal">
            <label>Название</label>
            <input
              placeholder="Nike"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
            ></input>
          </div>
          <div className="form__modal">
            <label>Цена</label>
            <input
              placeholder="500"
              value={price}
              onChange={(e) => setPrice(e.target.value)}
            ></input>
          </div>
          <div className="form__modal">
            <label>Img</label>
            <input
              placeholder="ссылка на картинку"
              value={img}
              onChange={(e) => setImg(e.target.value)}
            ></input>
          </div>
          <button
            onClick={() => Put()}
            style={{
              display: "flex",
              margin: "0px auto",
              backgroundColor: "lightgrey",
              padding: "10px 30px",
            }}
          >
            Add
          </button>
        </form>
      </Modal>

      <button onClick={() => AddSneaker()} className="gb-table">
        ADD SNEAKER
      </button>
      <table className="table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Price</th>
            <th>Img</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          {sneakersData.map((sneaker) => (
            <tr>
              <td>{sneaker.id}</td>
              <td>{sneaker.title}</td>
              <td>{sneaker.price}</td>
              <td>{sneaker.img}</td>
              <td className="">
                <button
                  className="gb-table"
                  onClick={() => EditSneaker(sneaker.id)}
                >
                  Edit
                </button>
                <button
                  className="gb-table"
                  onClick={() => {
                    DeleteSneaker(sneaker.id);
                  }}
                >
                  Delete
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default TableSneaker;
