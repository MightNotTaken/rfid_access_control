class MainService {
    count = 0
    http = new HTTP();
    updateScreen = async function() {
        try {
            document.getElementById('data').innerText = await this.getNextCount()
            await this.updateScreen()
        } catch (error) {
            await this.updateScreen()
        }
    }

    getNextCount = async function() {
        return new Promise((res, rej) => {
            try {
                setTimeout(() => {
                    this.http.get('http://localhost:3030/count').then(response => {
                        res(response.count)
                    }, error => rej(error))
                }, 1000);
            } catch (error) {
                res(this.count)
            }
        })
    }

}

const _ = new MainService()

window.onload = () => {
    _.updateScreen();
}