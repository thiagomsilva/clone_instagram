import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received({ post_id, comment_created }) {
    const comments = document.querySelector(".comments");

    // Se o usuário estiver no post correto de um cometário específico segue o fluxo, caso contrário retorna nada.
    if (parseInt(comments.dataset.postId) !== post_id) return;

    const template = document.createElement("template");
    template.innerHTML = comment_created;

    document.querySelector("form.new-comment")
    // Para o comentário aparecer corretamente entre o avatar do usuário e o campo onde são feitos os comentários.
      .insertAdjacentElement("beforebegin", template.content.firstChild);
  }
});