import consumer from "./consumer"

const initPartyCable = () => {
  const messagesContainer = document.getElementById('messages');
  console.log(messagesContainer);
  if (messagesContainer) {
    const id = messagesContainer.dataset.partyId;

    consumer.subscriptions.create({ channel: "PartyChannel", id: id }, {
      received(data) {
        console.log(data);
         messagesContainer.insertAdjacentHTML('beforeend', data); // called when data is broadcast in the cable
      },
    });
  }
}

export { initPartyCable };
