
def change_opacity(increase=False):
    with open("/home/knuffelbeer/.config/alacritty/alacritty.toml", "r") as grub_file:
        data = grub_file.readlines()
        for i, line in enumerate(data):
            if line.startswith("  opacity ="):
                current_opacity = float(line[len("  opacity =") :])
                if current_opacity - 0.1 >= 0:
                    data.pop(i)
                    current_opacity -= 0.1
                    data.insert(i, f"  opacity = {current_opacity}\n")

    with open("/home/knuffelbeer/.config/alacritty/alacritty.toml", "w") as grub_file:
        grub_file.writelines(data)


change_opacity()
