enum Sender { self, other }

class Message {
  const Message({required this.sender, this.onPressed});

  final Sender sender;
  final Function()? onPressed;
}
