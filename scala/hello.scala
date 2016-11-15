object HelloWorld {
  /* Main method */
  def main(args: Array[String]): Unit = {
    print("Hello ")
    for (name <- args) {
      print(name + " ")
    }
    println("!")
  }
}
