workspace {
    !adrs documentation/adr
    model {

        candidate = person "Candidate" "Candidate of NPO help"
        nonprofit = person "Non-Profit company representative" "NPO representative that administrate the NPO profile on platform"
        vulenteer = person "Vulenteer" "Vulenteer of NPO"

        enterprise DiversityCyberCounsil {
          admin = person "Admin" "System administrator"
          spotlightApp = softwareSystem "SpotlightApp" "SpotlightApp platform" {
            !docs documentation/spotlight-app
            group "AWS" {
              VPC = container "VPC" "Virtual Private Network" "AWS VPC" "Amazon Web Services - Fargate" {
                candidateService = component "candidate-service" "Manages/provides candidates data."
                nonProfitService = component "non-profit-service" "Manages/provides NPO."
                communityService = component "community-service" "Manages/provides community data."
                roadmapService = component "roadmap-service" "Manages candidates roadmaps."
              }
              fileStorage = container "file-storage" "File storage." "AWS S3" "Amazon Web Services - Simple Storage Service S3"
              apiGateway = container "api-gateway" " Handles inbound communication - authentisation/authorisation." "AWS API Gateway" "Amazon Web Services - API Gateway"
              authorizer = container "authorizer" "Authorization/authentication of user using federalized authority." "AWS Lambda" "Amazon Web Services - Lambda"
              identityPool = container "identity-pool" "Identity pool with roles management" "AWS Cognito" "Amazon Web Services - Cognito"
            }
            webApplication = container "WebApplication" "Spotlight Web Application"
          }

        }

        emailServer = softwareSystem "e-mail server" {
         !docs documentation/email-server
        }


        admin -> spotlightApp "Administrate"
        candidate -> spotlightApp "Uses"
        nonprofit -> spotlightApp "Uses"

        webApplication -> apiGateway
        apiGateway -> candidateService
        apiGateway -> nonProfitService
        apiGateway -> communityService

        apiGateway -> authorizer
        authorizer -> identityPool

        candidateService -> roadmapService
        candidateService -> communityService
        nonProfitService -> roadmapService
        nonProfitService -> candidateService
        nonProfitService -> communityService

        candidateService -> emailServer
        nonProfitService -> emailServer

        candidateService -> fileStorage
        nonProfitService -> fileStorage
        roadmapService -> fileStorage


        spotlightApp -> emailServer "Send notification"
    }

    views {
        systemContext spotlightApp "SpotlightApp" {
            include *
            autoLayout
        }

        container spotlightApp "SpotlightAppContainer" {
          include *
          autoLayout
        }

        component VPC "VPCComponent" {
          include *
          autoLayout
        }

        themes default https://static.structurizr.com/themes/amazon-web-services-2020.04.30/theme.json
    }

}
