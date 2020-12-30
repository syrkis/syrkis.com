export default () => (
  <div>
    <header>
      <div className="title">
        <h1>NOAH SYRKIS</h1>
      </div>
    </header>
    <style jsx>{`
      
      header {
        text-align: center;
        letter-spacing: 0.4em;
        height: 110vh;
        background:linear-gradient(to top, rgba(255, 255, 255, 255) 0%, rgba(255, 255, 255, 0) 75%, rgba(0, 0, 0, 0) 100%), url('https://images.syrkis.com/static/bright.jpg');
        background-position: center;
        background-size: cover;
        position: absolute;
        width: 100%;
      }

      h1 {
        font-size: 2.2em;
      }

      .title {
        padding-top: 47vh;
      }
      
    `}</style>
  </div>
)
