* ...
<h1 align="center">
  Importer of Financial Securities - API Rest
</h1>

<h3 align="center">
  API that imports financial securities, and checks for cases of securities-related criticisms.
</h3>

<p align="center">
  <a href="#-about-the-project">About the project</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-technologies">Technologies</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-getting-started">Getting started</a>
</p>


## 💼 About the project

<p>
  To understand the API, access the [DOCUMENTATION.](https://spice-spandex-6d5.notion.site/Documenta-o-API-de-Registros-de-T-tulos-Financeiros-ad522c9be20842519fdc19a714a8c28b)
</p>

## 🛸 Technologies

Technologies that I used to develop this api

- [Ruby](https://www.ruby-lang.org/pt/)
- [Rails](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/)
- [Docker](https://www.docker.com/)
- [Rspec](https://rspec.info/)
- [Postman](https://www.postman.com/)
- [Redis](https://redis.io/)
- [Sidekiq](https://sidekiq.org/)

<table>
  <tr>
    <td>Ruby version</td>
    <td>
      3.0.3
    </td>
  </tr>
  <tr>
    <td>Rails version</td>
    <td>
      7.0.2
    </td>
  </tr>
  <tr>
    <td>Database</td>
    <td>
      PostgreSQL
    </td>
  </tr>
</table>


## 💻 Getting started

### Requirements

- [Docker/Docker-Compose](https://docs.docker.com/get-docker/)
- [Postman](https://www.postman.com/)

You can follow this tutorials for installing Docker and Docker Compose:
- [Install Docker - Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
- [Install Docker Compose - Ubuntu](https://docs.docker.com/compose/install/)

**Clone the project and access the folder**

```bash
git clone https://github.com/MihaelGuedes/importer_of_financial_securities.git && cd importer_of_financial_securities
```

**To run the application using Docker Compose**
```bash
sudo docker-compose up --build
```

**Migrate de Database in another terminal**
```bash
docker-compose exec app bundle exec rake db:setup db:migrate
```


**To check the tests run**
```bash
docker-compose exec app rspec
```

### Testing the API with Postman

**1. Open your posman, and import the file "collection_api_titles_import.postman_collection.json" at the root of this project.**

![importação](https://user-images.githubusercontent.com/61971675/163098705-c1bc7682-3606-41b0-bbe4-c5a9635cf8e4.gif)

**2. In the collection we will have two requests types, one to import titles and another to view titles with some filters.**

![importacao_titulo_e_visualizacao](https://user-images.githubusercontent.com/61971675/163104602-5599d715-c0c1-415e-b9e8-efdb18f615b1.gif)

----------------------------------------------------------------------------------

Feito com 💙 por Mihael Guedes 👋 [Acesse meu linkedin](https://www.linkedin.com/in/mihaelguedes/)